module 0x460ee7f811c470e4426d7f56917385d913a1e85060a4b99d60d97e9c4243fd06::j1d {
    struct J1D has drop {
        dummy_field: bool,
    }

    fun init(arg0: J1D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J1D>(arg0, 9, b"J1D", b"just buy $1 worth of this coin", b"Just buy it for 1 dollar, suddenly it turns into a million", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0d991c1d3db03b052ed74175e3573649blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J1D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J1D>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

