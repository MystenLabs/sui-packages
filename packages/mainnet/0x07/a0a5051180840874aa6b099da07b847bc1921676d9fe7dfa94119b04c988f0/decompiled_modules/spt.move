module 0x7a0a5051180840874aa6b099da07b847bc1921676d9fe7dfa94119b04c988f0::spt {
    struct SPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPT>(arg0, 9, b"SPT", b"SUPERTUS", b"SPT TOP1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac891430-bc13-4b46-8467-15d83b512cc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

