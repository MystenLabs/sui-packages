module 0x1571764ef27733829d71a220c23c8eb8b61c5443d02fcb04937210a732dded69::kangaroo {
    struct KANGAROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANGAROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANGAROO>(arg0, 9, b"Kangaroo", b"7Kangaroo", b"Hello friends, I am the 7k Kangaroo. Let's jump high!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/779578e34b04001f6678cadbc181e22ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KANGAROO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANGAROO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

