module 0x32fd4f6acb7734263dd77c7fcea853f392babd6f871a2cae5a5c85dda821536d::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 9, b"WTF", b"Walrus The Force", x"496e74726f647563696e672024575446202857616c7275732054686520466f7263652920e280932074686520756c74696d617465206d656d65636f696e20666f72205374617220576172732066616e7320616e64206d656d65206c6f7665727320616c696b652120496e7370697265642062792074686520616e6369656e7420776973646f6d206f6620746865204a6564692028616e6420746865206d6967687479207475736b73206f6620612077616c727573292c202457544620626c656e64732074686520706f776572206f66206d656d6573207769746820746865206d61676963206f6620626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2ba0619ff311025bf7d3a14548ca897ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

