module 0x815a9b6100c8a08b68de9d1758cd3ccfb979909faa76a70704df8df6ab49f30b::bitesuicoin {
    struct BITESUICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITESUICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITESUICOIN>(arg0, 6, b"BITESUICOIN", b"B1TECOIN", b"Like Bitcoin, but way more fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_14_163437174_ded6357239.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITESUICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITESUICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

