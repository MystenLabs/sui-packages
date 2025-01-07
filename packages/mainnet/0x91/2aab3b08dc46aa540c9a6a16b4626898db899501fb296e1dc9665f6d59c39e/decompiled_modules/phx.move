module 0x912aab3b08dc46aa540c9a6a16b4626898db899501fb296e1dc9665f6d59c39e::phx {
    struct PHX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHX>(arg0, 9, b"PHX", b"Sui Phoenix", b"an immortal bird that cyclically regenerates or is otherwise born again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Jayc7cP.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<PHX>(&mut v2, 100000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHX>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHX>>(v1);
    }

    // decompiled from Move bytecode v6
}

