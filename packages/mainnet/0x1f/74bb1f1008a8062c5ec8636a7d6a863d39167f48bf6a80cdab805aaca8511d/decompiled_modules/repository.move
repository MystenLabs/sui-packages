module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::repository {
    struct REPOSITORY has drop {
        dummy_field: bool,
    }

    struct Repository has store, key {
        id: 0x2::object::UID,
        version: u64,
        client_version: 0x1::string::String,
        fees: 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::Fees,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Repository {
        Repository{
            id             : 0x2::object::new(arg3),
            version        : 1,
            client_version : 0x1::string::utf8(b"0.0.0"),
            fees           : 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::new(arg0, arg1, arg2),
        }
    }

    public(friend) fun fees(arg0: &Repository) : &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::Fees {
        &arg0.fees
    }

    public fun fee(arg0: &Repository, arg1: u64) : u64 {
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::fee(&arg0.fees, arg1)
    }

    public entry fun set_fees(arg0: &mut Repository, arg1: &0x2::package::Publisher, arg2: u64, arg3: u64) {
        assert_publisher(arg1);
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::set_fees(&mut arg0.fees, arg2, arg3);
    }

    public entry fun set_recipient(arg0: &mut Repository, arg1: &0x2::package::Publisher, arg2: address) {
        assert_publisher(arg1);
        0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::fees::set_recipient(&mut arg0.fees, arg2);
    }

    fun assert_publisher(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<REPOSITORY>(arg0), 0);
    }

    public fun assert_version(arg0: &Repository) {
        assert!(arg0.version == 1, 1);
    }

    fun init(arg0: REPOSITORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<REPOSITORY>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = new(100, 76, v1, arg1);
        0x2::transfer::public_share_object<Repository>(v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_client_version(arg0: &mut Repository, arg1: &0x2::package::Publisher, arg2: 0x1::string::String) {
        assert_publisher(arg1);
        arg0.client_version = arg2;
    }

    public entry fun upgrade_version(arg0: &mut Repository, arg1: &0x2::package::Publisher) {
        assert_publisher(arg1);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

