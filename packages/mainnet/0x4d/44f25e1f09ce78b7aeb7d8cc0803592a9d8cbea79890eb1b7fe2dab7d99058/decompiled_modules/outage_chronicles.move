module 0x4d44f25e1f09ce78b7aeb7d8cc0803592a9d8cbea79890eb1b7fe2dab7d99058::outage_chronicles {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ReceiptConsumerCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        mint_enabled: bool,
        mint_count: u64,
        max_mint_count: u64,
    }

    struct OutageSft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        serial: u64,
    }

    struct BurnReceipt {
        burned_id: 0x2::object::ID,
        burner: address,
        serial: u64,
        image_url: 0x1::string::String,
    }

    struct BurnReceiptData has copy, drop, store {
        burned_id: 0x2::object::ID,
        burner: address,
        serial: u64,
        image_url: 0x1::string::String,
    }

    struct BurnPermit has key {
        id: 0x2::object::UID,
        sft_id: 0x2::object::ID,
        owner: address,
    }

    public fun authorize_burn(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnPermit{
            id     : 0x2::object::new(arg3),
            sft_id : arg1,
            owner  : arg2,
        };
        0x2::transfer::transfer<BurnPermit>(v0, arg2);
    }

    public fun burn(arg0: OutageSft, arg1: &0x2::tx_context::TxContext) : BurnReceipt {
        burn_for_receipt(arg0, 0x2::tx_context::sender(arg1))
    }

    fun burn_for_receipt(arg0: OutageSft, arg1: address) : BurnReceipt {
        let OutageSft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : v3,
            serial      : v4,
        } = arg0;
        let v5 = v0;
        0x2::object::delete(v5);
        BurnReceipt{
            burned_id : 0x2::object::uid_to_inner(&v5),
            burner    : arg1,
            serial    : v4,
            image_url : v3,
        }
    }

    public fun burn_receipt_burned_id(arg0: &BurnReceipt) : 0x2::object::ID {
        arg0.burned_id
    }

    public fun burn_receipt_burner(arg0: &BurnReceipt) : address {
        arg0.burner
    }

    public fun burn_receipt_data_burned_id(arg0: &BurnReceiptData) : 0x2::object::ID {
        arg0.burned_id
    }

    public fun burn_receipt_data_burner(arg0: &BurnReceiptData) : address {
        arg0.burner
    }

    public fun burn_receipt_data_image_url(arg0: &BurnReceiptData) : 0x1::string::String {
        arg0.image_url
    }

    public fun burn_receipt_data_serial(arg0: &BurnReceiptData) : u64 {
        arg0.serial
    }

    public fun burn_receipt_image_url(arg0: &BurnReceipt) : 0x1::string::String {
        arg0.image_url
    }

    public fun burn_receipt_serial(arg0: &BurnReceipt) : u64 {
        arg0.serial
    }

    public fun burn_with_permit(arg0: OutageSft, arg1: BurnPermit, arg2: &0x2::tx_context::TxContext) {
        let BurnPermit {
            id     : v0,
            sft_id : v1,
            owner  : v2,
        } = arg1;
        assert!(0x2::tx_context::sender(arg2) == v2, 4);
        assert!(0x2::object::id<OutageSft>(&arg0) == v1, 3);
        0x2::object::delete(v0);
        delete_sft(arg0);
    }

    public fun config_description(arg0: &MintConfig) : 0x1::string::String {
        arg0.description
    }

    public fun config_name(arg0: &MintConfig) : 0x1::string::String {
        arg0.name
    }

    public fun consume_burn_receipt(arg0: &ReceiptConsumerCap, arg1: BurnReceipt) : BurnReceiptData {
        let BurnReceipt {
            burned_id : v0,
            burner    : v1,
            serial    : v2,
            image_url : v3,
        } = arg1;
        BurnReceiptData{
            burned_id : v0,
            burner    : v1,
            serial    : v2,
            image_url : v3,
        }
    }

    fun create_initial_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ReceiptConsumerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ReceiptConsumerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = MintConfig{
            id             : 0x2::object::new(arg0),
            name           : 0x1::string::utf8(b"Sui Outage #3"),
            description    : 0x1::string::utf8(b"Mint your personalized rescue edition."),
            mint_enabled   : false,
            mint_count     : 0,
            max_mint_count : 10000,
        };
        0x2::transfer::share_object<MintConfig>(v2);
    }

    fun delete_sft(arg0: OutageSft) {
        let OutageSft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            serial      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun image_url_from_path(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://sui-outage-images.mindfrog.xyz/");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_initial_state(arg0);
    }

    public fun max_mint_count(arg0: &MintConfig) : u64 {
        arg0.max_mint_count
    }

    public fun mint(arg0: &mut MintConfig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mint_enabled, 0);
        assert!(!0x1::string::is_empty(&arg1), 1);
        assert!(arg0.mint_count < arg0.max_mint_count, 2);
        let v0 = OutageSft{
            id          : 0x2::object::new(arg2),
            name        : arg0.name,
            description : arg0.description,
            image_url   : image_url_from_path(arg1),
            serial      : arg0.mint_count + 1,
        };
        arg0.mint_count = arg0.mint_count + 1;
        0x2::transfer::transfer<OutageSft>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun mint_count(arg0: &MintConfig) : u64 {
        arg0.mint_count
    }

    public fun mint_enabled(arg0: &MintConfig) : bool {
        arg0.mint_enabled
    }

    public fun set_max_mint_count(arg0: &AdminCap, arg1: &mut MintConfig, arg2: u64) {
        arg1.max_mint_count = arg2;
    }

    public fun set_metadata(arg0: &AdminCap, arg1: &mut MintConfig, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        arg1.name = arg2;
        arg1.description = arg3;
    }

    public fun set_mint_enabled(arg0: &AdminCap, arg1: &mut MintConfig, arg2: bool) {
        arg1.mint_enabled = arg2;
    }

    public fun sft_description(arg0: &OutageSft) : 0x1::string::String {
        arg0.description
    }

    public fun sft_image_url(arg0: &OutageSft) : 0x1::string::String {
        arg0.image_url
    }

    public fun sft_name(arg0: &OutageSft) : 0x1::string::String {
        arg0.name
    }

    public fun sft_serial(arg0: &OutageSft) : u64 {
        arg0.serial
    }

    // decompiled from Move bytecode v6
}

