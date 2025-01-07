module 0xbd7a66b3cfdff45feb02add9d161481b3a2230a79c5e354b18e38392a26a9c95::babyaxol {
    struct BABYAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYAXOL>(arg0, 6, b"BabyAxol", b"BabyAXOL", x"4d65657420244241425941584f4c2c207468652061646f7261626c65206c6974746c65207377696d6d6572206f6e202353554920212064697665206465657020616e64206d616b6520776176657320746f676574686572212041786f6c206973206d79204461640a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735877396191.gUfno8YodAgFqcHE0H4snEnp5AQB7dX4KaUrQoVPSW0")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYAXOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYAXOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

