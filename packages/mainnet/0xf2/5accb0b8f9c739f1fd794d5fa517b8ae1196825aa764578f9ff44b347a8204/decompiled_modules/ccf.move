module 0xf25accb0b8f9c739f1fd794d5fa517b8ae1196825aa764578f9ff44b347a8204::ccf {
    struct CCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCF>(arg0, 9, b"CCF", b"cryptochief", b"Have a nice btc!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4059e137b8ed0ee4a5e9512b437acdb1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

