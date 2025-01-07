module 0x6c7d4efd549a4fc284d02f351a49a4cc1407c1f243cf0538c212983e77286056::zard {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARD>(arg0, 6, b"ZARD", b"SupLizards", b"Lizard storm is sweeping on #Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LIZARD_53996b290a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

