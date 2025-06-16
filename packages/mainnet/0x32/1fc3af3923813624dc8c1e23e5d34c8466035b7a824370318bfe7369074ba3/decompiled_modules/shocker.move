module 0x321fc3af3923813624dc8c1e23e5d34c8466035b7a824370318bfe7369074ba3::shocker {
    struct SHOCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCKER>(arg0, 6, b"SHOCKER", b"The Shocler", b"Your mom's favorite coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750087314346.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOCKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

