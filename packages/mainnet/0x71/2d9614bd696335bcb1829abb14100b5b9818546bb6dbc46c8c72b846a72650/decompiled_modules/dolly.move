module 0x712d9614bd696335bcb1829abb14100b5b9818546bb6dbc46c8c72b846a72650::dolly {
    struct DOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLY>(arg0, 9, b"Dolly", b"Dolly the sheep", x"446f6c6c79202835204a756c79203139393620e280932031342046656272756172792032303033292077617320612066656d616c652046696e6e2d446f7273657420736865657020616e6420746865206669727374206d616d6d616c20746861742077617320636c6f6e65642066726f6d20616e206164756c7420736f6d617469632063656c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/6vYsFBK")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOLLY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

