module 0xfd135fc1fb3512e918dd14a00427cdfbf047a69764b9b84145573ffaeddd2285::dos {
    struct DOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOS>(arg0, 6, b"DOS", b"DORKLORD On Sui", b"Prepare yourself, young Padawan, for the most epic memecoin in the $SUI galaxy: DORKLORD! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOKRLOR_84068bcef4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

