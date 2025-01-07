module 0xe313025c500d551042a7a8d4110f0c3b5522fada286496ef775cc19096ef5af9::wmm {
    struct WMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMM>(arg0, 9, b"WMM", b"Witch", b"Witch meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/870de724-eb00-42f7-bece-5a87c5181253-A658A9AC-7FFE-491B-AF56-DF1C5B66372F.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

