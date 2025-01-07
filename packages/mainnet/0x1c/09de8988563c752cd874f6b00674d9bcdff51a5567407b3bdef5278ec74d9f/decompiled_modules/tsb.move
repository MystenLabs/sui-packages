module 0x1c09de8988563c752cd874f6b00674d9bcdff51a5567407b3bdef5278ec74d9f::tsb {
    struct TSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSB>(arg0, 9, b"TSB", b"Tsubasa", b"Only for football anime lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSB>>(v1);
    }

    // decompiled from Move bytecode v6
}

