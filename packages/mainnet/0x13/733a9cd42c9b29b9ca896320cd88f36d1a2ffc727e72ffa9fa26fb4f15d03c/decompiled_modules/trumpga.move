module 0x13733a9cd42c9b29b9ca896320cd88f36d1a2ffc727e72ffa9fa26fb4f15d03c::trumpga {
    struct TRUMPGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPGA>(arg0, 9, b"TRUMPGA", b"Chickencoin", b"TRUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ddc8be97e2f343255f42d57931a6effablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

