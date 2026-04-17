module 0xef3d9dd89c8895440bdbc9ef1535798510e2c454b9ce5176df249f21f223d5af::shared_obj {
    struct SharedObject has store, key {
        id: 0x2::object::UID,
        value: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : SharedObject {
        SharedObject{
            id    : 0x2::object::new(arg0),
            value : 0,
        }
    }

    public fun inc(arg0: &mut SharedObject) {
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SharedObject>(new(arg0));
    }

    // decompiled from Move bytecode v6
}

