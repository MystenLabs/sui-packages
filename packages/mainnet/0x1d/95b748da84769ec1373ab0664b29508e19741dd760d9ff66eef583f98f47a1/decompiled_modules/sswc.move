module 0x1d95b748da84769ec1373ab0664b29508e19741dd760d9ff66eef583f98f47a1::sswc {
    struct SSWC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSWC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWC>(arg0, 6, b"SSWC", b"SuiSwine Coin", b"The SuiSwine story, in which the warthog almost became human, adapted but finally broke free is amazing - and full of wisdom! See it on Youtube! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_68_1d53fae4c7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSWC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSWC>>(v1);
    }

    // decompiled from Move bytecode v6
}

