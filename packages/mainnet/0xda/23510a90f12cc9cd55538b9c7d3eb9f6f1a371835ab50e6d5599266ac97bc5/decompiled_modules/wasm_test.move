module 0xda23510a90f12cc9cd55538b9c7d3eb9f6f1a371835ab50e6d5599266ac97bc5::wasm_test {
    struct MyUrl has copy, drop, store {
        url: 0x1::string::String,
    }

    struct MyObject has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        num: u16,
    }

    struct MyStruct {
        id: u8,
        name: 0x1::string::String,
        urls: vector<MyUrl>,
    }

    struct MyStructT<T0, phantom T1> {
        id: u8,
        name: 0x1::string::String,
        x: Foo<T0>,
        y: Foo3<T1>,
    }

    struct Foo3<phantom T0> {
        dummy_field: bool,
    }

    struct Foo<T0> {
        x: T0,
        for: T0,
    }

    struct Foo2<T0, T1> {
        num1: u16,
        x: T0,
        num2: u16,
        y: T0,
        z: T0,
        num3: bool,
        v: vector<vector<T1>>,
    }

    public fun get() : u8 {
        10
    }

    public fun get_foo() : Foo<u16> {
        Foo<u16>{
            x   : 100,
            for : 200,
        }
    }

    fun get_online_val() : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::error::incorrect_version()
    }

    public fun get_str() : 0x1::string::String {
        0x1::string::utf8(b"JUSTIN_NFT")
    }

    public fun get_struct() : MyStruct {
        MyStruct{
            id   : 100,
            name : 0x1::string::utf8(b"get_struct"),
            urls : 0x1::vector::empty<MyUrl>(),
        }
    }

    fun get_sui_url() : 0x2::url::Url {
        0x2::url::new_unsafe_from_bytes(b"www.baidu.com")
    }

    public fun get_vec() : (address, 0x1::string::String, u8, vector<u16>, MyUrl) {
        let v0 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v0, 10);
        0x1::vector::push_back<u16>(&mut v0, 20);
        let v1 = MyUrl{url: 0x1::string::utf8(b"www.baidu.com")};
        (@0x89b9f9d1fadc027cf9532d6f99041522, 0x1::string::utf8(b"JUSTIN_MFT"), 10, v0, v1)
    }

    public fun set_foo(arg0: Foo<u16>) : Foo<u16> {
        arg0
    }

    public fun set_foo2<T0>(arg0: Foo<T0>) : Foo<T0> {
        arg0
    }

    public fun set_foo3(arg0: Foo2<u8, u16>) : Foo2<u8, u16> {
        arg0
    }

    public fun set_foo5<T0>(arg0: Foo2<T0, u16>) : Foo2<T0, u16> {
        arg0
    }

    public fun set_foo6<T0>(arg0: Foo2<Foo2<T0, u16>, u8>) : Foo2<Foo2<T0, u16>, u8> {
        arg0
    }

    public fun set_foo_str(arg0: Foo<0x1::string::String>) : Foo<0x1::string::String> {
        arg0
    }

    public fun set_foo_vector(arg0: vector<Foo<u16>>) : vector<Foo<u16>> {
        arg0
    }

    public fun set_foo_vector2<T0>(arg0: vector<Foo<T0>>) : vector<Foo<T0>> {
        arg0
    }

    public fun set_foo_vector3<T0>() : vector<Foo<T0>> {
        0x1::vector::empty<Foo<T0>>()
    }

    public fun set_foo_vector5<T0>(arg0: &vector<u8>, arg1: vector<vector<u64>>) : (vector<Foo<T0>>, vector<vector<u64>>) {
        (0x1::vector::empty<Foo<T0>>(), arg1)
    }

    public fun set_int(arg0: u16) : u16 {
        arg0
    }

    public fun set_myobject(arg0: &MyObject) : u16 {
        100
    }

    public fun set_struct(arg0: MyStruct) : vector<MyStruct> {
        let v0 = 0x1::vector::empty<MyStruct>();
        0x1::vector::push_back<MyStruct>(&mut v0, arg0);
        v0
    }

    public fun set_struct_t<T0>(arg0: T0) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v0, arg0);
        v0
    }

    public fun set_struct_t2<T0>(arg0: T0) : T0 {
        arg0
    }

    // decompiled from Move bytecode v6
}

