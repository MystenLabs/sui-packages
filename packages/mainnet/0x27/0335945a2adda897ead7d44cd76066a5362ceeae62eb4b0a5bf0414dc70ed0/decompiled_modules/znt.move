module 0x270335945a2adda897ead7d44cd76066a5362ceeae62eb4b0a5bf0414dc70ed0::znt {
    struct ZNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZNT>(arg0, 9, b"ZNT", b"Zion Trade", b"Crypto trade system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf79fbeb-11de-4546-a424-173f14cac781.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

