module 0x69dda7399b8c5bbf8e4f26e8a4f25473e19e16c1776c8f8cbb6438dc0e0e8767::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 6, b"P", b"The america Party", b"Elon party donal trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/assets/tokens/0c1296cb-f706-498a-920b-1b1e49ba144d.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<P>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

