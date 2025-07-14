module 0xdc0edd617d0d6d0c6f9fa1f89d77ff297ef753ed0bce3beb45584fe90a549005::crymiao {
    struct CRYMIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYMIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYMIAO>(arg0, 9, b"Crymiao", b"Crymow", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/18975fc1cd22027c2407737691951975blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYMIAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYMIAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

