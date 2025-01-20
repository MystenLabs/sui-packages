module 0x7efc03ed5b9597318bd93d0445302808a00f5a67e010410fce81fdcaef78d15e::addon {
    struct ADDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDON>(arg0, 6, b"AddOn", b"AddOn AI", b"Monetize your Ai Agents / Socials and Earn Passive Income. Deploy Ai Advertisement Agents. Access Multiple Ai Tools. Brought to you by $AddOn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737341325819.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

