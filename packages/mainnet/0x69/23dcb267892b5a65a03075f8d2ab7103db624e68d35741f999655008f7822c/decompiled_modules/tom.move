module 0x6923dcb267892b5a65a03075f8d2ab7103db624e68d35741f999655008f7822c::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 9, b"TOM", b"Tom Cat", b"Not Jerry ! Catch the Cash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1809235017362468864/_LTyNDV8_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

