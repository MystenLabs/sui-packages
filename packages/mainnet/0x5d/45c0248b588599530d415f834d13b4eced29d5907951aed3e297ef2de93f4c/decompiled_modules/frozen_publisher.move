module 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::frozen_publisher {
    struct FROZEN_PUBLISHER has drop {
        dummy_field: bool,
    }

    struct FrozenPublisher has key {
        id: 0x2::object::UID,
        inner: 0x2::package::Publisher,
    }

    public fun new(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : FrozenPublisher {
        FrozenPublisher{
            id    : 0x2::object::new(arg1),
            inner : arg0,
        }
    }

    public fun public_freeze_object(arg0: FrozenPublisher) {
        0x2::transfer::freeze_object<FrozenPublisher>(arg0);
    }

    public fun borrow_publisher<T0>(arg0: 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness::Witness<T0>, arg1: &FrozenPublisher) : &0x2::package::Publisher {
        assert!(0x2::package::from_module<T0>(&arg1.inner), 0);
        &arg1.inner
    }

    public fun freeze_from_otw<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<T0>(arg0, arg1);
        public_freeze_object(new(v0, arg1));
    }

    fun init(arg0: FROZEN_PUBLISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FROZEN_PUBLISHER>(arg0, arg1);
        let v1 = 0x2::display::new<FrozenPublisher>(&v0, arg1);
        0x2::display::add<FrozenPublisher>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"FrozenPublisher"));
        0x2::display::add<FrozenPublisher>(&mut v1, 0x1::string::utf8(b"url"), 0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::originbyte_docs_url());
        0x2::display::add<FrozenPublisher>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Enables access to Publisher via witness::Witness"));
        0x2::transfer::public_freeze_object<0x2::display::Display<FrozenPublisher>>(v1);
        0x2::package::burn_publisher(v0);
    }

    public fun mod(arg0: &FrozenPublisher) : &0x1::ascii::String {
        0x2::package::published_module(&arg0.inner)
    }

    public fun new_display<T0: drop, T1: key>(arg0: T0, arg1: &FrozenPublisher, arg2: &mut 0x2::tx_context::TxContext) : 0x2::display::Display<T1> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::assert_same_module<T0, T1>();
        0x2::display::new<T1>(&arg1.inner, arg2)
    }

    public fun pkg(arg0: &FrozenPublisher) : &0x1::ascii::String {
        0x2::package::published_package(&arg0.inner)
    }

    // decompiled from Move bytecode v6
}

