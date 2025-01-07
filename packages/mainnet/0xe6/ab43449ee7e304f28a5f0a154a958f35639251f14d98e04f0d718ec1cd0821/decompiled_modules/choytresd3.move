module 0xe6ab43449ee7e304f28a5f0a154a958f35639251f14d98e04f0d718ec1cd0821::choytresd3 {
    struct CHOYTRESD3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOYTRESD3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOYTRESD3>(arg0, 9, b"CHOYTRESD3", b"MeM$", b"Coin fruts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0ee7add-190f-4daa-85fb-774e79bc59b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOYTRESD3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHOYTRESD3>>(v1);
    }

    // decompiled from Move bytecode v6
}

