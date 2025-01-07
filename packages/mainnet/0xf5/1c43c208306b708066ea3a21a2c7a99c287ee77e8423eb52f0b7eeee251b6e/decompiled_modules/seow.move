module 0xf51c43c208306b708066ea3a21a2c7a99c287ee77e8423eb52f0b7eeee251b6e::seow {
    struct SEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEOW>(arg0, 9, b"SEOW", b"suicat", b"I am not a pet. Am here to rule !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/08c2ca15cc8bf8f001fd519c300feda3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

