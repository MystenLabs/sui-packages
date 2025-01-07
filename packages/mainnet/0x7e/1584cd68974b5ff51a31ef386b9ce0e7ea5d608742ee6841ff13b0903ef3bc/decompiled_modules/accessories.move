module 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories {
    struct ACCESSORIES has drop {
        dummy_field: bool,
    }

    struct Accessory has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct AccessoryKey has copy, drop, store {
        type: 0x1::string::String,
    }

    struct MintCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MintCap has store {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: Accessory) {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0);
        let v1 = AccessoryKey{type: arg1.type};
        assert!(!0x2::dynamic_object_field::exists_<AccessoryKey>(v0, v1), 1);
        let v2 = AccessoryKey{type: arg1.type};
        0x2::dynamic_object_field::add<AccessoryKey, Accessory>(v0, v2, arg1);
    }

    public fun remove<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: 0x1::string::String) : Accessory {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0);
        let v1 = AccessoryKey{type: arg1};
        assert!(0x2::dynamic_object_field::exists_<AccessoryKey>(v0, v1), 0);
        let v2 = AccessoryKey{type: arg1};
        0x2::dynamic_object_field::remove<AccessoryKey, Accessory>(v0, v2)
    }

    public fun app_new_accessory_key(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String) : AccessoryKey {
        let v0 = MintCapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<MintCapKey, MintCap>(arg0, v0), 2);
        AccessoryKey{type: arg1}
    }

    public fun authorize_app(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut 0x2::object::UID) {
        let v0 = MintCapKey{dummy_field: false};
        let v1 = MintCap{dummy_field: false};
        0x2::dynamic_field::add<MintCapKey, MintCap>(arg1, v0, v1);
    }

    public fun deauthorize_app(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut 0x2::object::UID) {
        let v0 = MintCapKey{dummy_field: false};
        let MintCap {  } = 0x2::dynamic_field::remove<MintCapKey, MintCap>(arg1, v0);
    }

    public fun has_accessory_type<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: 0x1::string::String) : bool {
        let v0 = AccessoryKey{type: arg1};
        0x2::dynamic_object_field::exists_<AccessoryKey>(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0), v0)
    }

    fun init(arg0: ACCESSORIES, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<ACCESSORIES>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Accessory {
        let v0 = MintCapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<MintCapKey, MintCap>(arg0, v0), 2);
        Accessory{
            id   : 0x2::object::new(arg3),
            name : arg1,
            type : arg2,
        }
    }

    public fun name(arg0: &Accessory) : 0x1::string::String {
        arg0.name
    }

    public fun type(arg0: &Accessory) : 0x1::string::String {
        arg0.type
    }

    // decompiled from Move bytecode v6
}

