module 0xc55c872b5bd6075d275ac978abdaa3dd2a573bd4d3ef2095b9a79a077c497670::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TST", b"test", b"This is a test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Ffc05.deviantart.net%2Ffs70%2Fi%2F2012%2F030%2F6%2Fd%2Fmoonboy_by_jakobhansson-d4o3vyn.jpg&f=1&nofb=1&ipt=2ad4a448b475fbed3e57b4dbba64c686b6beff03509aeb897715a23525622066")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v2, 1000000000000000000, arg1), @0x8c50b9ab868d6ad4e7fd57a49bcb4a572cdfdb75f18ebaf85e5a0d26c21b30e8);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

