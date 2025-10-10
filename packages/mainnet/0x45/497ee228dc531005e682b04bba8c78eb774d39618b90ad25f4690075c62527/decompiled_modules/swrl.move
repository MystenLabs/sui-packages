module 0x45497ee228dc531005e682b04bba8c78eb774d39618b90ad25f4690075c62527::swrl {
    struct SWRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWRL>(arg0, 6, b"SWRL", b"Swirlie", b"Give a swirlie, get a swirlie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760125619610.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWRL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWRL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

