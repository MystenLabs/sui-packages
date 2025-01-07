module 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct BORROW_REQ has drop {
        dummy_field: bool,
    }

    struct ReturnPromise<phantom T0, phantom T1> {
        nft_id: 0x2::object::ID,
    }

    struct BorrowRequest<phantom T0: drop, T1: store + key> {
        nft_id: 0x2::object::ID,
        nft: 0x1::option::Option<T1>,
        sender: address,
        field: 0x1::option::Option<0x1::type_name::TypeName>,
        promise: 0x2::kiosk::Borrow,
        inner: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>>,
    }

    public fun add_receipt<T0: drop, T1: store + key, T2>(arg0: &mut BorrowRequest<T0, T1>, arg1: &T2) {
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::add_receipt<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>, T2>(&mut arg0.inner, arg1);
    }

    public fun assert_is_borrow_field<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) {
        assert!(is_borrow_field<T0, T1>(arg0), 0);
    }

    public fun assert_is_borrow_nft<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) {
        assert!(is_borrow_nft<T0, T1>(arg0), 0);
    }

    public fun borrow_field<T0: store + key, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID) : (T1, ReturnPromise<T0, T1>) {
        let v0 = ReturnPromise<T0, T1>{nft_id: 0x2::object::uid_to_inner(arg1)};
        (0x2::dynamic_field::remove<0x1::type_name::TypeName, T1>(arg1, 0x1::type_name::get<T1>()), v0)
    }

    public fun borrow_nft<T0: drop, T1: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T1>, arg1: &mut BorrowRequest<T0, T1>) : T1 {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg1.field), 0);
        0x1::option::extract<T1>(&mut arg1.nft)
    }

    public fun borrow_nft_ref_mut<T0: drop, T1: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T1>, arg1: &mut BorrowRequest<T0, T1>) : &mut T1 {
        0x1::option::borrow_mut<T1>(&mut arg1.nft)
    }

    public fun confirm<T0: drop, T1: store + key>(arg0: T0, arg1: BorrowRequest<T0, T1>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>>) : (T1, 0x2::kiosk::Borrow) {
        assert!(0x1::option::is_some<T1>(&arg1.nft), 0);
        let BorrowRequest {
            nft_id  : _,
            nft     : v1,
            sender  : _,
            field   : _,
            promise : v4,
            inner   : v5,
        } = arg1;
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::confirm<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>>(v5, arg2);
        (0x1::option::destroy_some<T1>(v1), v4)
    }

    public fun field<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) : 0x1::type_name::TypeName {
        *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.field)
    }

    public fun init_policy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, BORROW_REQ>>, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::PolicyCap) {
        let v0 = BORROW_REQ{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::new_policy_with_type<T0, BORROW_REQ>(v0, arg0, arg1)
    }

    public fun inner_mut<T0: drop, T1: store + key>(arg0: &mut BorrowRequest<T0, T1>) : &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>> {
        &mut arg0.inner
    }

    public fun is_borrow_field<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) : bool {
        0x1::option::is_some<0x1::type_name::TypeName>(&arg0.field)
    }

    public fun is_borrow_nft<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) : bool {
        0x1::option::is_none<0x1::type_name::TypeName>(&arg0.field)
    }

    public fun new<T0: drop, T1: store + key>(arg0: T0, arg1: T1, arg2: address, arg3: 0x1::option::Option<0x1::type_name::TypeName>, arg4: 0x2::kiosk::Borrow, arg5: &mut 0x2::tx_context::TxContext) : BorrowRequest<T0, T1> {
        BorrowRequest<T0, T1>{
            nft_id  : 0x2::object::id<T1>(&arg1),
            nft     : 0x1::option::some<T1>(arg1),
            sender  : arg2,
            field   : arg3,
            promise : arg4,
            inner   : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::new<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, BORROW_REQ>>(arg5),
        }
    }

    public fun nft_id<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) : 0x2::object::ID {
        0x2::object::id<T1>(0x1::option::borrow<T1>(&arg0.nft))
    }

    public fun return_field<T0: store + key, T1: store>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::object::UID, arg2: ReturnPromise<T0, T1>, arg3: T1) {
        assert!(0x2::object::uid_to_inner(arg1) == arg2.nft_id, 0);
        0x2::dynamic_field::add<0x1::type_name::TypeName, T1>(arg1, 0x1::type_name::get<T1>(), arg3);
        let ReturnPromise {  } = arg2;
    }

    public fun return_nft<T0: drop, T1: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T1>, arg1: &mut BorrowRequest<T0, T1>, arg2: T1) {
        assert!(0x2::object::id<T1>(&arg2) == arg1.nft_id, 0);
        0x1::option::fill<T1>(&mut arg1.nft, arg2);
    }

    public fun tx_sender<T0: drop, T1: store + key>(arg0: &BorrowRequest<T0, T1>) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

