module 0x5791cfd034bdd4238ed20729823f3f3963d6ab10f0bbb5e98f967d762a30f48f::simoncat {
    struct SIMONCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMONCAT>(arg0, 6, b"SIMONCAT", b"Simon's Cat", x"57656c636f6d6520746f207468652053696d6f6e277320436174204d656d6520776562736974652e0a4f4e45204341542c2042494c4c494f4e53204f46204f574e455253210a534159204e4f20544f20454d50545920424f574c530a45766572792074726164652066656564732068756e67727920636174732061726f756e642074686520776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/simon_244e7de689.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMONCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMONCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

