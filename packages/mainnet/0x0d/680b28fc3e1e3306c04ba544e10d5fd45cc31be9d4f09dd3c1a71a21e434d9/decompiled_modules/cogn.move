module 0xd680b28fc3e1e3306c04ba544e10d5fd45cc31be9d4f09dd3c1a71a21e434d9::cogn {
    struct COGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COGN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COGN>(arg0, 6, b"COGN", b"Cognita", b"Cognita aims to create a decentralized marketplace for AI-generated assets and services. It will function as a specialized platform where developers can publish, license, and sell AI models, and users can access and utilize these models for a wide range of applications, from content creation to data analysis. The COGN token will be the native currency for all transactions within this ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/unnamed_ed21d52eb4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COGN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COGN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

