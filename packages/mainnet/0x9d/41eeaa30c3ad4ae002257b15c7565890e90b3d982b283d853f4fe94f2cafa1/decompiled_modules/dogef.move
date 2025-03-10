module 0x9d41eeaa30c3ad4ae002257b15c7565890e90b3d982b283d853f4fe94f2cafa1::dogef {
    struct DOGEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEF>(arg0, 6, b"DOGEF", b"Official DOGEFather", x"4f6666696369616c20444f47454661746865722028444f4745462920e280932054686520556c74696d617465204d656d6520426f73732120f09f90b6f09f92b020426f726e2066726f6d20746865206c6567656e6461727920446f6765206c696e656167652c20444f4745462069732074686520676f64666174686572206f6620616c6c206d656d6520636f696e7321204e6f207574696c6974792c206e6f20726f61646d6170e280946a75737420707572652066756e20616e64206d6f6f6e20647265616d732e20f09f9a80f09f9095", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741642083210.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

