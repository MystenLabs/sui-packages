module 0xf459e9f6c8d2247eab916c5b888da7b46b95503747af0f77009d88638912be0e::lemon {
    struct LEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMON>(arg0, 9, b"LEMON", b"LEMONY", x"4a55494359204c454d4f4e0a4c45545320484156452046554e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54ec4c981e6dd3f94dcad1203c7eb4f6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

