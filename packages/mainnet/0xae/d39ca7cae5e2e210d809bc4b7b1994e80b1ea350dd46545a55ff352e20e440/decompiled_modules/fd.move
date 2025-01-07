module 0xaed39ca7cae5e2e210d809bc4b7b1994e80b1ea350dd46545a55ff352e20e440::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 9, b"FD", b"FortuneDime", b"hold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk_X3thoOBABZ_G-AMh1Iey0QhBn0Ne23XxtdzzMUKfwp289JulLXjs713yzR9qKb67OA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

