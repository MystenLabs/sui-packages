module 0x5c5cc96819a53fbd82dffb98aa3b92e3729bbbe334f4f4d37dafd0122b82adda::jhi {
    struct JHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHI>(arg0, 8, b"JHI", b"JHI", b"My friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1733169563&X-Expires=315360000&X-Method=GET&X-Signature=d322305d95265efdfb1a55fb284060173a05a5e2f6fa21227a7e3162a817e4f1"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JHI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

