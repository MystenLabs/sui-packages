module 0xaf4344bee132a915cac16fc7472dd6d8ca949b50a1897464354f32bfba344f5b::xigma {
    struct XIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIGMA>(arg0, 6, b"XIGMA", b"SUI SIGMA DUDEZ", b"an Icon on SUI representing all Sigma's Dudez pumping the market for \"Whatever\" labels The Market calling him (eg:etc), while he remains unbothered and laser-focused.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_funny_meme_cartoon_49a20e7afe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

