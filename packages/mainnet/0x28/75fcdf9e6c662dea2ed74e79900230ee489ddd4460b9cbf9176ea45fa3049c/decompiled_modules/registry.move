module 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::registry {
    struct OrderInfo has drop, store {
        order_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        side: u8,
        quote_type: 0x1::type_name::TypeName,
        asset_type: 0x1::type_name::TypeName,
        min_out: u64,
        created_at_ms: u64,
        expiry_ms: u64,
    }

    struct OrderRegistry has key {
        id: 0x2::object::UID,
        orders: 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::LinkedTable<0x2::object::ID, OrderInfo>,
    }

    public fun length(arg0: &OrderRegistry) : u64 {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::length<0x2::object::ID, OrderInfo>(&arg0.orders)
    }

    public fun borrow(arg0: &OrderRegistry, arg1: 0x2::object::ID) : &OrderInfo {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::borrow<0x2::object::ID, OrderInfo>(&arg0.orders, arg1)
    }

    public fun contains(arg0: &OrderRegistry, arg1: 0x2::object::ID) : bool {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::contains<0x2::object::ID, OrderInfo>(&arg0.orders, arg1)
    }

    public fun is_empty(arg0: &OrderRegistry) : bool {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::is_empty<0x2::object::ID, OrderInfo>(&arg0.orders)
    }

    public fun next(arg0: &OrderRegistry, arg1: 0x2::object::ID) : &0x1::option::Option<0x2::object::ID> {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::next<0x2::object::ID, OrderInfo>(&arg0.orders, arg1)
    }

    public(friend) fun remove(arg0: &mut OrderRegistry, arg1: 0x2::object::ID) {
        if (0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::contains<0x2::object::ID, OrderInfo>(&arg0.orders, arg1)) {
            0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::remove<0x2::object::ID, OrderInfo>(&mut arg0.orders, arg1);
        };
    }

    public(friend) fun add(arg0: &mut OrderRegistry, arg1: 0x2::object::ID, arg2: OrderInfo) {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::push_back<0x2::object::ID, OrderInfo>(&mut arg0.orders, arg1, arg2);
    }

    public fun first(arg0: &OrderRegistry) : &0x1::option::Option<0x2::object::ID> {
        0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::front<0x2::object::ID, OrderInfo>(&arg0.orders)
    }

    public fun info_asset_type(arg0: &OrderInfo) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun info_created_at_ms(arg0: &OrderInfo) : u64 {
        arg0.created_at_ms
    }

    public fun info_expiry_ms(arg0: &OrderInfo) : u64 {
        arg0.expiry_ms
    }

    public fun info_min_out(arg0: &OrderInfo) : u64 {
        arg0.min_out
    }

    public fun info_order_id(arg0: &OrderInfo) : 0x2::object::ID {
        arg0.order_id
    }

    public fun info_owner(arg0: &OrderInfo) : address {
        arg0.owner
    }

    public fun info_quote_type(arg0: &OrderInfo) : 0x1::type_name::TypeName {
        arg0.quote_type
    }

    public fun info_recipient(arg0: &OrderInfo) : address {
        arg0.recipient
    }

    public fun info_side(arg0: &OrderInfo) : u8 {
        arg0.side
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderRegistry{
            id     : 0x2::object::new(arg0),
            orders : 0x22441207010a3d050260a878d1adacb1989ab3c99104e818c2228f19701d1204::linked_table::new<0x2::object::ID, OrderInfo>(arg0),
        };
        0x2::transfer::share_object<OrderRegistry>(v0);
    }

    public(friend) fun new_info(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u8, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64) : OrderInfo {
        OrderInfo{
            order_id      : arg0,
            owner         : arg1,
            recipient     : arg2,
            side          : arg3,
            quote_type    : arg4,
            asset_type    : arg5,
            min_out       : arg6,
            created_at_ms : arg7,
            expiry_ms     : arg8,
        }
    }

    public(friend) fun side_buy() : u8 {
        0
    }

    public(friend) fun side_sell() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

