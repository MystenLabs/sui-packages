module 0xa3b091d99e38bf09c9361a0305604f033144b5ece23617bd7293be90a797d3c::b_fdd {
    struct B_FDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FDD>(arg0, 9, b"bFDD", b"bToken FDD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

