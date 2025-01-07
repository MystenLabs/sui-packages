module 0x4698e991fd2766a2c90376a9fc6598500c82c4e417b9a6e139c6ec790603fb36::suigrandma {
    struct SUIGRANDMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGRANDMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGRANDMA>(arg0, 9, b"suigrandma", b"Suigrandma", b"grandma's suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGRANDMA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGRANDMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGRANDMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

