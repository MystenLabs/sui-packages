module 0x4c303cbabd4e81f685d98d07678006a8d85e247c363cae75c5452e4000826dc1::glp {
    struct GLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLP>(arg0, 6, b"GLP", b"Golden LeoPard", b"The golden leopard is a popular meme on the internet. This meme originated from a video on the TikTok short-video platform. Netizens shared that changing to a golden leopard avatar means there will be money in the new year, that is, getting rich suddenly. This meme is a claim circulating on the internet. The golden leopard is homophonic with \"Jin qiaobao(into the wallet)\", so changing to a golden leopard avatar is considered to bring good fortune in terms of wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MTXX_MH_20230602_233900657_9d81d493d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

