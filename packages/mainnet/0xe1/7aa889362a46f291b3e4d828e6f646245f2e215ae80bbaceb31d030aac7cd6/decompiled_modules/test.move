module 0xe17aa889362a46f291b3e4d828e6f646245f2e215ae80bbaceb31d030aac7cd6::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"TEST TOKEN22", b"THIS IS A TEST TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.squarespace-cdn.com/content/v1/5a2e89106f4ca325a6238e9c/1558456946888-ADNR9SEL1NV8788H4ODY/test.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

