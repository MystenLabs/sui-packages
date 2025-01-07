module 0x48ceae964530f0b6b7164f56c8c5cbc6b572c2665f2a3624342182da0a854e9::bitcoin {
    struct BITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 602 || 0x2::tx_context::epoch(arg1) == 603, 1);
        let (v0, v1) = 0x2::coin::create_currency<BITCOIN>(arg0, 9, b"BTC", b"Bitcoin", b"Bitcoin is the first successful internet money based on peer-to-peer technology; whereby no central bank or authority is involved in the transaction and production of the Bitcoin currency. It was created by an anonymous individual/group under the name, Satoshi Nakamoto. The source code is available publicly as an open source project, anybody can look at it and be part of the developmental process.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreicwf73wega7luowx6w6xhmuyb53toin24yv5g3kgiwkfad6dw3ywa.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BITCOIN>(&mut v2, 21000000000000000, @0xbbe6dea33d7712e65b8ec4ffca1308b534244fcad4b70e1c53980d3ac7768fd9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCOIN>>(v2, @0xbbe6dea33d7712e65b8ec4ffca1308b534244fcad4b70e1c53980d3ac7768fd9);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BITCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<BITCOIN>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BITCOIN>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<BITCOIN>, arg1: &mut 0x2::coin::CoinMetadata<BITCOIN>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<BITCOIN>(arg0, arg1, arg2);
        0x2::coin::update_symbol<BITCOIN>(arg0, arg1, arg3);
        0x2::coin::update_description<BITCOIN>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<BITCOIN>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

