module 0xc483d0140c9d2678fa37966328e88d08ef4bb0dafdd973e6849a99caf938c7::slsp {
    struct SLSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLSP>(arg0, 9, b"SLSP", b"SL SWAP", b"SLSWAP COMMING SON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLSP>(&mut v2, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLSP>>(v2, @0x2f359d1b9710961faf62d11c71457eb29ee27de4ed4719bf22a5657d5e91759e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

