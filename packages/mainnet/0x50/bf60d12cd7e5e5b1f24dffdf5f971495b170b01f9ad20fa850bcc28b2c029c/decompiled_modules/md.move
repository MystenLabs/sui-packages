module 0x50bf60d12cd7e5e5b1f24dffdf5f971495b170b01f9ad20fa850bcc28b2c029c::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"My dog", b"My best friend golden retriever ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/45be8378dec1a105e7c4ffc750a774cablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

