module 0x2e02f684db75dc0ad0eaa83a2cbdc34ff09300c7b0b525656ec781972ffbf29f::tgr {
    struct TGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGR>(arg0, 9, b"TGR", b"Tiger", b"Tiger coin on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TGR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

