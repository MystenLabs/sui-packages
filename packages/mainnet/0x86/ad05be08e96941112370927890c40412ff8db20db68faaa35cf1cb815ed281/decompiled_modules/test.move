module 0x86ad05be08e96941112370927890c40412ff8db20db68faaa35cf1cb815ed281::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TEST", b"test", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreie6lyo67k7bpcr5pe2shzlgosiho7e2yrpdvp6yqojb267kywd344?X-Algorithm=PINATA1&X-Date=1736841742&X-Expires=315360000&X-Method=GET&X-Signature=a458a668a2e04c1dc4444dfed79b6e1722c27781978b2fa061043c476ee07256")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

