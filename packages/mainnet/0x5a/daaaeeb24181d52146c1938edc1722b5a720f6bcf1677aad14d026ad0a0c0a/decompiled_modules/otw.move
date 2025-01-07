module 0x5adaaaeeb24181d52146c1938edc1722b5a720f6bcf1677aad14d026ad0a0c0a::otw {
    struct OTW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTW>(arg0, 6, b"OTW", b"Open To Work", b"Open To Work ($OTW) is a community-driven meme token that playfully captures the spirit of job seekers and professional networking culture. Just like that familiar \"Open To Work\" banner on social profiles, this token represents the hustle, hope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965124525.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

