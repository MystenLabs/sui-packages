module 0x9d92f5a6d26b7b1110e3d85f2d9b2ac6a4c23eec8fc28a4f7332ca72651a89a6::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"sad", b"Launch a project on @suilaunchcoin by tagging @EmanAbio and including the project name and logo. $sad + sad silliont", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sad-fgaihw.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

