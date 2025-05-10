module 0x2c0524388e9c742ebbf9cf09a01c2c0bd1c18b3b01677afb383620f58b87868a::derilic {
    struct DERILIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERILIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERILIC>(arg0, 9, b"DERILIC", b"DERILIC", b"A great man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagekit.io/tools/asset-public-link?detail=%7B%22name%22%3A%22IMG_20250510_210943_228.jpg%22%2C%22type%22%3A%22image%2Fjpeg%22%2C%22signedurl_expire%22%3A%222028-05-09T15%3A44%3A46.658Z%22%2C%22signedUrl%22%3A%22https%3A%2F%2Fmedia-hosting.imagekit.io%2Febcb0d5a391b4c3d%2FIMG_20250510_210943_228.jpg%3FExpires%3D1841499887%26Key-Pair-Id%3DK2ZIVPTIP2VGHC%26Signature%3DedO-7IYywPHP9qMl7-viAQaCtIpQfWOLMQuorZtd0~sp9C3MldvMJQPbcIaIHsu0ogv2U7Y8CM1MbUgW5x734vQJoljnHwKTGxRr98jQJsN5kOrW9UZ1-sfTMIMjSyTi1TiWUnTSQA1qIIkYADdq19xcTjnqsu2Thr6-sWX0l8H8SNmywCDBF~bwJtQ7cLZ-afP-R0JZuC72uqQWUc4qg6yiYsDc1EdWxmnofXE~nEbMN3kRu2l8hxGEBBmmNZtr3wfOwptpcsUfw4uPC-S~W4C2Rew6-IZFXOTmYm~ByamXeugjO7z6ukKEBfRNq1-2JL9vs~fqjjgOzMNeFGAc1g__%22%7D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DERILIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERILIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERILIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

