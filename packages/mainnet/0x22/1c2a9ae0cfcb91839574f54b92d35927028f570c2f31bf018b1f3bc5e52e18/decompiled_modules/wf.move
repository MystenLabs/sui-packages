module 0x221c2a9ae0cfcb91839574f54b92d35927028f570c2f31bf018b1f3bc5e52e18::wf {
    struct WF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WF>(arg0, 9, b"WF", b"WaveFun", b"This is a fun token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24e0aa4b-d5cc-48e0-879a-2a48deb4ec0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WF>>(v1);
    }

    // decompiled from Move bytecode v6
}

