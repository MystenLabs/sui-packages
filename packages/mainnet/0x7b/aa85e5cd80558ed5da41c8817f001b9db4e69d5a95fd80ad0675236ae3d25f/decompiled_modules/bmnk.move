module 0x7baa85e5cd80558ed5da41c8817f001b9db4e69d5a95fd80ad0675236ae3d25f::bmnk {
    struct BMNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMNK>(arg0, 9, b"BMNK", b"babymonkey", b"NEW MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/856360a9-a2e0-45a9-8955-31e12fffa33c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

