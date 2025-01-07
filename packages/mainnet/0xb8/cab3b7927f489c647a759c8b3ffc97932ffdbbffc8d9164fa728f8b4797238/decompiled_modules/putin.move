module 0xb8cab3b7927f489c647a759c8b3ffc97932ffdbbffc8d9164fa728f8b4797238::putin {
    struct PUTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTIN>(arg0, 6, b"PUTIN", b"VLODIMIR", b"Best history teacher ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MW_DJ_519_E_Pc7_FX_20150413113709_NS_31e30490d1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

