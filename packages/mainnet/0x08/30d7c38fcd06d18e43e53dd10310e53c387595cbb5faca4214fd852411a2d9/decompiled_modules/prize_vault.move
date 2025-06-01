module 0x830d7c38fcd06d18e43e53dd10310e53c387595cbb5faca4214fd852411a2d9::prize_vault {
    struct PRIZE_VAULT has drop {
        dummy_field: bool,
    }

    struct PrizeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PrizeTypeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PrizeMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PrizeVault has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        prize_description: 0x1::string::String,
        prize_value: u64,
        creator: address,
        has_prize: bool,
        creation_time: u64,
    }

    struct DepositReceipt has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        depositor: address,
        deposit_time: u64,
    }

    struct ClaimTicket has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        recipient: address,
        authorized_by: address,
        issued_time: u64,
    }

    struct PrizeDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        depositor: address,
        deposit_time: u64,
    }

    struct PrizeClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        recipient: address,
        claim_time: u64,
    }

    struct PrizeReclaimed has copy, drop {
        vault_id: 0x2::object::ID,
        prize_type: 0x1::string::String,
        prize_name: 0x1::string::String,
        original_depositor: address,
        reclaim_time: u64,
    }

    struct ClaimTicketIssued has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        authorized_by: address,
        issued_time: u64,
    }

    public entry fun claim_nft_prize<T0: store + key>(arg0: &mut PrizeVault, arg1: ClaimTicket, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == arg1.vault_id, 4);
        assert!(0x2::tx_context::sender(arg3) == arg1.recipient, 4);
        assert!(arg0.prize_type == 0x1::string::utf8(b"NFT"), 1);
        assert!(arg0.has_prize, 2);
        let v0 = PrizeTypeKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<PrizeTypeKey>(&arg0.id, v0), 3);
        let v1 = PrizeTypeKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<PrizeTypeKey, 0x1::string::String>(&arg0.id, v1) == 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), 1);
        let v2 = PrizeKey{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_<PrizeKey>(&arg0.id, v2), 3);
        let v3 = PrizeKey{dummy_field: false};
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<PrizeKey, T0>(&mut arg0.id, v3), 0x2::tx_context::sender(arg3));
        arg0.has_prize = false;
        let v4 = PrizeClaimed{
            vault_id   : arg0.vault_id,
            prize_type : arg0.prize_type,
            prize_name : arg0.prize_name,
            recipient  : 0x2::tx_context::sender(arg3),
            claim_time : arg2,
        };
        0x2::event::emit<PrizeClaimed>(v4);
        let ClaimTicket {
            id            : v5,
            vault_id      : _,
            recipient     : _,
            authorized_by : _,
            issued_time   : _,
        } = arg1;
        0x2::object::delete(v5);
    }

    public entry fun claim_token_prize(arg0: &mut PrizeVault, arg1: ClaimTicket, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == arg1.vault_id, 4);
        assert!(0x2::tx_context::sender(arg3) == arg1.recipient, 4);
        assert!(arg0.prize_type == 0x1::string::utf8(b"TOKEN"), 1);
        assert!(arg0.has_prize, 2);
        let v0 = PrizeKey{dummy_field: false};
        arg0.has_prize = false;
        let v1 = PrizeClaimed{
            vault_id   : arg0.vault_id,
            prize_type : arg0.prize_type,
            prize_name : arg0.prize_name,
            recipient  : 0x2::tx_context::sender(arg3),
            claim_time : arg2,
        };
        0x2::event::emit<PrizeClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PrizeKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0), 0x2::tx_context::sender(arg3));
        let ClaimTicket {
            id            : v2,
            vault_id      : _,
            recipient     : _,
            authorized_by : _,
            issued_time   : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public fun create_nft_vault<T0: store + key>(arg0: T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (PrizeVault, DepositReceipt) {
        let v0 = PrizeVault{
            id                : 0x2::object::new(arg4),
            vault_id          : 0x2::object::id_from_address(@0x0),
            prize_type        : 0x1::string::utf8(b"NFT"),
            prize_name        : arg1,
            prize_description : arg2,
            prize_value       : 0,
            creator           : 0x2::tx_context::sender(arg4),
            has_prize         : true,
            creation_time     : arg3,
        };
        v0.vault_id = 0x2::object::id<PrizeVault>(&v0);
        let v1 = PrizeTypeKey{dummy_field: false};
        0x2::dynamic_field::add<PrizeTypeKey, 0x1::string::String>(&mut v0.id, v1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v2 = PrizeKey{dummy_field: false};
        0x2::dynamic_object_field::add<PrizeKey, T0>(&mut v0.id, v2, arg0);
        let v3 = DepositReceipt{
            id           : 0x2::object::new(arg4),
            vault_id     : 0x2::object::id<PrizeVault>(&v0),
            prize_type   : 0x1::string::utf8(b"NFT"),
            prize_name   : arg1,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        let v4 = PrizeDeposited{
            vault_id     : 0x2::object::id<PrizeVault>(&v0),
            prize_type   : 0x1::string::utf8(b"NFT"),
            prize_name   : arg1,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        0x2::event::emit<PrizeDeposited>(v4);
        (v0, v3)
    }

    public fun create_token_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (PrizeVault, DepositReceipt) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 5);
        let v1 = PrizeVault{
            id                : 0x2::object::new(arg4),
            vault_id          : 0x2::object::id_from_address(@0x0),
            prize_type        : 0x1::string::utf8(b"TOKEN"),
            prize_name        : arg1,
            prize_description : arg2,
            prize_value       : v0,
            creator           : 0x2::tx_context::sender(arg4),
            has_prize         : true,
            creation_time     : arg3,
        };
        v1.vault_id = 0x2::object::id<PrizeVault>(&v1);
        let v2 = PrizeKey{dummy_field: false};
        0x2::dynamic_field::add<PrizeKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut v1.id, v2, arg0);
        let v3 = DepositReceipt{
            id           : 0x2::object::new(arg4),
            vault_id     : 0x2::object::id<PrizeVault>(&v1),
            prize_type   : 0x1::string::utf8(b"TOKEN"),
            prize_name   : arg1,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        let v4 = PrizeDeposited{
            vault_id     : 0x2::object::id<PrizeVault>(&v1),
            prize_type   : 0x1::string::utf8(b"TOKEN"),
            prize_name   : arg1,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        0x2::event::emit<PrizeDeposited>(v4);
        (v1, v3)
    }

    public entry fun deposit_nft_prize<T0: store + key>(arg0: &mut PrizeVault, arg1: T0, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.has_prize, 6);
        let v0 = PrizeTypeKey{dummy_field: false};
        0x2::dynamic_field::add<PrizeTypeKey, 0x1::string::String>(&mut arg0.id, v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = PrizeKey{dummy_field: false};
        0x2::dynamic_object_field::add<PrizeKey, T0>(&mut arg0.id, v1, arg1);
        arg0.has_prize = true;
        arg0.prize_type = 0x1::string::utf8(b"NFT");
        arg0.prize_name = 0x1::string::utf8(arg2);
        let v2 = DepositReceipt{
            id           : 0x2::object::new(arg4),
            vault_id     : arg0.vault_id,
            prize_type   : arg0.prize_type,
            prize_name   : arg0.prize_name,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        let v3 = PrizeDeposited{
            vault_id     : arg0.vault_id,
            prize_type   : arg0.prize_type,
            prize_name   : arg0.prize_name,
            depositor    : 0x2::tx_context::sender(arg4),
            deposit_time : arg3,
        };
        0x2::event::emit<PrizeDeposited>(v3);
        0x2::transfer::public_transfer<DepositReceipt>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun get_prize_type(arg0: &PrizeVault) : 0x1::string::String {
        arg0.prize_type
    }

    public fun get_vault_info(arg0: &PrizeVault) : (0x2::object::ID, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64, address, bool, u64) {
        (arg0.vault_id, arg0.prize_type, arg0.prize_name, arg0.prize_description, arg0.prize_value, arg0.creator, arg0.has_prize, arg0.creation_time)
    }

    public fun has_prize_of_type<T0: store + key>(arg0: &PrizeVault) : bool {
        if (!arg0.has_prize) {
            return false
        };
        if (arg0.prize_type != 0x1::string::utf8(b"NFT")) {
            return false
        };
        let v0 = PrizeTypeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PrizeTypeKey>(&arg0.id, v0)) {
            let v1 = PrizeTypeKey{dummy_field: false};
            return *0x2::dynamic_field::borrow<PrizeTypeKey, 0x1::string::String>(&arg0.id, v1) == 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
        };
        false
    }

    public fun has_token_prize(arg0: &PrizeVault) : (bool, u64) {
        if (!arg0.has_prize || arg0.prize_type != 0x1::string::utf8(b"TOKEN")) {
            return (false, 0)
        };
        (true, arg0.prize_value)
    }

    fun init(arg0: PRIZE_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PRIZE_VAULT>(arg0, arg1);
        let v1 = 0x2::display::new<DepositReceipt>(&v0, arg1);
        0x2::display::add<DepositReceipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prize Deposit Receipt"));
        0x2::display::add<DepositReceipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Receipt for {prize_name} deposited by {depositor}"));
        0x2::display::add<DepositReceipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/receipt-image/{vault_id}"));
        0x2::display::update_version<DepositReceipt>(&mut v1);
        let v2 = 0x2::display::new<ClaimTicket>(&v0, arg1);
        0x2::display::add<ClaimTicket>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prize Claim Ticket"));
        0x2::display::add<ClaimTicket>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ticket to claim prize from vault {vault_id}"));
        0x2::display::add<ClaimTicket>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://sui-raffles.io/claim-ticket-image/{vault_id}"));
        0x2::display::update_version<ClaimTicket>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DepositReceipt>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ClaimTicket>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun issue_claim_ticket(arg0: &PrizeVault, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ClaimTicket {
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 4);
        assert!(arg0.has_prize, 2);
        let v0 = ClaimTicket{
            id            : 0x2::object::new(arg3),
            vault_id      : arg0.vault_id,
            recipient     : arg1,
            authorized_by : 0x2::tx_context::sender(arg3),
            issued_time   : arg2,
        };
        let v1 = ClaimTicketIssued{
            vault_id      : arg0.vault_id,
            recipient     : arg1,
            authorized_by : 0x2::tx_context::sender(arg3),
            issued_time   : arg2,
        };
        0x2::event::emit<ClaimTicketIssued>(v1);
        v0
    }

    public entry fun reclaim_prize<T0: store + key>(arg0: &mut PrizeVault, arg1: DepositReceipt, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.vault_id == arg1.vault_id, 4);
        assert!(0x2::tx_context::sender(arg3) == arg1.depositor, 4);
        assert!(arg0.has_prize, 2);
        if (arg0.prize_type == 0x1::string::utf8(b"TOKEN")) {
            let v0 = PrizeKey{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PrizeKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0), 0x2::tx_context::sender(arg3));
        } else {
            let v1 = PrizeTypeKey{dummy_field: false};
            assert!(0x2::dynamic_field::exists_<PrizeTypeKey>(&arg0.id, v1), 3);
            let v2 = PrizeTypeKey{dummy_field: false};
            assert!(*0x2::dynamic_field::borrow<PrizeTypeKey, 0x1::string::String>(&arg0.id, v2) == 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), 1);
            let v3 = PrizeKey{dummy_field: false};
            assert!(0x2::dynamic_object_field::exists_<PrizeKey>(&arg0.id, v3), 3);
            let v4 = PrizeKey{dummy_field: false};
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<PrizeKey, T0>(&mut arg0.id, v4), 0x2::tx_context::sender(arg3));
        };
        arg0.has_prize = false;
        let v5 = PrizeReclaimed{
            vault_id           : arg0.vault_id,
            prize_type         : arg0.prize_type,
            prize_name         : arg0.prize_name,
            original_depositor : arg1.depositor,
            reclaim_time       : arg2,
        };
        0x2::event::emit<PrizeReclaimed>(v5);
        let DepositReceipt {
            id           : v6,
            vault_id     : _,
            prize_type   : _,
            prize_name   : _,
            depositor    : _,
            deposit_time : _,
        } = arg1;
        0x2::object::delete(v6);
    }

    // decompiled from Move bytecode v6
}

