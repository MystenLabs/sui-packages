module 0x1b10b8856426c9743c5326b6c501e3f11f433078006b6a14e02679c53d06946d::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 9, b"SEAL", b"Seal the Pokemon", b"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam in lorem non augue fermentum luctus eu quis lacus. Vivamus auctor lectus a libero vulputate, eget ultricies nisl efficitur. Donec elementum, dolor sed auctor vulputate, nibh ex tristique sapien, id lacinia orci sem eu odio. Donec maximus consectetur volutpat. Quisque viverra magna ut neque consectetur, rutrum pretium ipsum elementum. Donec fringilla, ante at scelerisque sodales, augue leo aliquam orci, ullamcorper volutpat diam est eget elit. In hac habitasse platea dictumst. Pellentesque ultrices erat purus, non volutpat sapien consectetur sed. Vivamus euismod sed massa a aliquam. Integer massa metus, consectetur sed elit id, iaculis tempor quam. Duis a nisi quis turpis aliquam maximus. Fusce quis lacus a odio hendrerit porttitor vitae non erat. Sed ut aliquet sapien, nec tincidunt dui. Suspendisse potenti. Ut feugiat, ligula eget commodo eleifend, tellus tortor auctor ligula, in ornare est dui eget odio. Ut varius lorem condimentum, facilisis mi vitae, imperdiet risus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/64691618980c5cb8f240bc91ad19f4b7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

