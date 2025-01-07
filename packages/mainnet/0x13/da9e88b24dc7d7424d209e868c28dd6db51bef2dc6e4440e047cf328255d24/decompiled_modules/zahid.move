module 0x13da9e88b24dc7d7424d209e868c28dd6db51bef2dc6e4440e047cf328255d24::zahid {
    struct ZAHID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAHID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAHID>(arg0, 9, b"ZAHID", b"Muhammad Z", b"This is very nice coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96c62842-e32f-460d-b502-028cd26e4ee5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAHID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAHID>>(v1);
    }

    // decompiled from Move bytecode v6
}

