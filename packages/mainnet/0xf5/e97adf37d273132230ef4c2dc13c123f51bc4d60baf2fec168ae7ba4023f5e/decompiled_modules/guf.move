module 0xf5e97adf37d273132230ef4c2dc13c123f51bc4d60baf2fec168ae7ba4023f5e::guf {
    struct GUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUF>(arg0, 9, b"GUF", b"gufii", x"4469736e6579e380804c4f5645", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/268dec88328ab4f95cd977f9600d8febblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

