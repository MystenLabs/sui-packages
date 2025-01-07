module 0xe2bda860019c4125842781dffb32cdf05d5213c18346db4364e257c67f7e0d05::tgh {
    struct TGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGH>(arg0, 9, b"TGH", b"SDFGH", b"AZxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/533ae6e5-7463-438d-8aef-caca482fe64d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

